package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/test-structure"
	"testing"
	"github.com/go-ping/ping"
)

const vmDirStage = "../examples/vm-module/single-vm/"

func createVmOpts(t *testing.T, terraformDir string) *terraform.Options {
	uniqueId := random.UniqueId()

	bucketForTesting := "myhomelab-xyz-terraform-up-n-run-example"
	bucketRegionForTesting := "us-east-2"
	vmStateKey := fmt.Sprintf("%s/%s/terraform.tfstate", t.Name(), uniqueId)
	return &terraform.Options{
		TerraformDir: terraformDir,
		Reconfigure: true,
		Vars: map[string]interface{}{
		"vm_name": fmt.Sprintf("test-%s", uniqueId),
		},
		BackendConfig: map[string]interface{}{
			"bucket": bucketForTesting,
			"region": bucketRegionForTesting,
			"key": vmStateKey,
			"encrypt": true,
		},
	}
}


func deployVm(t *testing.T, vmDir string) {
	vmOpts := createVmOpts(t, vmDir)
	// Save data to disk so that other test stages executed at a later
	// time can read the data back in
	test_structure.SaveTerraformOptions(t, vmDir, vmOpts)

	terraform.InitAndApply(t, vmOpts)
}

func teardownVm(t *testing.T, vmDir string) {
	vmOpts := test_structure.LoadTerraformOptions(t, vmDir)
	defer terraform.Destroy(t, vmOpts)
}

func validateVm(t *testing.T, vmDir string) {
	vmOpts := test_structure.LoadTerraformOptions(t, vmDir)
	pingVm(t, vmOpts)
}

func pingVm(t *testing.T, vmOpts *terraform.Options) {
	vmAddr := terraform.OutputRequired(t, vmOpts, "proxmox_vm_ip_address")

	// Ping VM
	pinger, err := ping.NewPinger(vmAddr)
	if err != nil {
			panic(err)
	}
	pinger.Count = 3

	pinger.OnRecv = func(pkt *ping.Packet) {
		fmt.Printf("%d bytes from %s: icmp_seq=%d time=%v\n",
			pkt.Nbytes, pkt.IPAddr, pkt.Seq, pkt.Rtt)
	}
	pinger.OnDuplicateRecv = func(pkt *ping.Packet) {
		fmt.Printf("%d bytes from %s: icmp_seq=%d time=%v ttl=%v (DUP!)\n",
			pkt.Nbytes, pkt.IPAddr, pkt.Seq, pkt.Rtt, pkt.Ttl)
	}	
	pinger.OnFinish = func(stats *ping.Statistics) {
		fmt.Printf("\n--- %s ping statistics ---\n", stats.Addr)
		fmt.Printf("%d packets transmitted, %d packets received, %v%% packet loss\n",
			stats.PacketsSent, stats.PacketsRecv, stats.PacketLoss)
		fmt.Printf("round-trip min/avg/max/stddev = %v/%v/%v/%v\n",
			stats.MinRtt, stats.AvgRtt, stats.MaxRtt, stats.StdDevRtt)
	}

	fmt.Printf("PING %s (%s):\n", pinger.Addr(), pinger.IPAddr())
	pinger.Run() // blocks until finished
}

func TestProxmoxSingleVmWithStages(t *testing.T) {
	t.Parallel()
	// Store the function in a short variable name
	stage := test_structure.RunTestStage
	// Deploy the VM
	defer stage(t, "teardown_vm", func() { teardownVm(t, vmDirStage) })
	stage(t, "deploy_vm", func() { deployVm(t, vmDirStage) })
	// Validate that VM is pinging
	stage(t, "ping_vm", func() { validateVm(t, vmDirStage) })
}