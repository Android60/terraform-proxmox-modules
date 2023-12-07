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
		"vm_name": fmt.Sprintf("test%s", uniqueId),
		},
		BackendConfig: map[string]interface{}{
			"bucket": bucketForTesting,
			"region": bucketRegionForTesting,
			"key": vmStateKey,
			"encrypt": true,
		},
	}
}

func deployVm(t *testing.T, vmAppDir string) {
	vmOpts := createVmOpts(t, vmAppDir)
	// Save data to disk so that other test stages executed at a later
	// time can read the data back in
	test_structure.SaveTerraformOptions(t, vmAppDir, vmOpts)

	terraform.InitAndApply(t, vmOpts)
}

func TestProxmoxVmWithStages(t *testing.T) {
	t.Parallel()
	// Store the function in a short variable name
	stage := test_structure.RunTestStage
	// Deploy the VM
	defer stage(t, "teardown_vm", func() { teardownVm(t, vmDirStage) })
	stage(t, "deploy_vm", func() { deployVm(t, vmDirStage) })
	// Validate that VM is pinging
	stage(t, "ping_vm", func() { pingVm(t, vmDirStage) })
}