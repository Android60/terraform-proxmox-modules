package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/test-structure"
	"testing"
)

const lxcDirStage = "../examples/lxc-module/single-ct/"

func createLxcOpts(t *testing.T, terraformDir string) *terraform.Options {
	uniqueId := random.UniqueId()
	genPass := random.UniqueId()
	bucketForTesting := "myhomelab-xyz-terraform-up-n-run-example"
	bucketRegionForTesting := "us-east-2"
	lxcStateKey := fmt.Sprintf("%s/%s/terraform.tfstate", t.Name(), uniqueId)
	return &terraform.Options{
		TerraformDir: terraformDir,
		Reconfigure: true,
		Vars: map[string]interface{}{
		"lxc_name": fmt.Sprintf("test-%s", uniqueId),
		"root_password": genPass,
		},
		BackendConfig: map[string]interface{}{
			"bucket": bucketForTesting,
			"region": bucketRegionForTesting,
			"key": lxcStateKey,
			"encrypt": true,
		},
	}
}


func deployLxc(t *testing.T, lxcDir string) {
	lxcOpts := createLxcOpts(t, lxcDir)
	// Save data to disk so that other test stages executed at a later
	// time can read the data back in
	test_structure.SaveTerraformOptions(t, lxcDir, lxcOpts)

	terraform.InitAndApply(t, lxcOpts)
}

func teardownLxc(t *testing.T, lxcDir string) {
	lxcOpts := test_structure.LoadTerraformOptions(t, lxcDir)
	defer terraform.Destroy(t, lxcOpts)
}

func validateLxc(t *testing.T, lxcDir string) {
	fmt.Printf("\n---Some-test---\n")
}

func TestProxmoxSingleCtWithStages(t *testing.T) {
	t.Parallel()
	// Store the function in a short variable name
	stage := test_structure.RunTestStage
	// Deploy the CT
	defer stage(t, "teardown_lxc", func() { teardownLxc(t, lxcDirStage) })
	stage(t, "deploy_lxc", func() { deployLxc(t, lxcDirStage) })
	// Validate that CT is pinging
	stage(t, "ping_lxc", func() { validateLxc(t, lxcDirStage) })
}