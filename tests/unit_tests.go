func deployVm(t *testing.T, dbDir string, helloAppDir string) {
	dbOpts := test_structure.LoadTerraformOptions(t, dbDir)
	helloOpts := createHelloOpts(dbOpts, helloAppDir)
	// Save data to disk so that other test stages executed at a later
	// time can read the data back in
	test_structure.SaveTerraformOptions(t, helloAppDir, helloOpts)

	terraform.InitAndApply(t, helloOpts)
}

func TestVmWithStages(t *testing.T) {
	t.Parallel()
	// Store the function in a short variable name
	stage := test_structure.RunTestStage
	// Deploy the VM
	defer stage(t, "teardown_vm", func() { teardownVm(t, vmDirStage) })
	stage(t, "deploy_vm", func() { deployVm(t, vmDirStage) })
	// Validate that VM is pinging
	stage(t, "ping_vm", func() { pingVm(t, vmDirStage) })
}