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