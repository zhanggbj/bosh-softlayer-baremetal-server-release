// This file was generated by counterfeiter
package fake_controllers

import (
	"sync"

	"code.cloudfoundry.org/lager"
	"github.com/cloudfoundry-community/vps/models"
	"github.com/cloudfoundry-community/vps/restapi/handlers"
)

type FakeVirtualGuestController struct {
	AllVirtualGuestsStub        func(logger lager.Logger) ([]*models.VM, error)
	allVirtualGuestsMutex       sync.RWMutex
	allVirtualGuestsArgsForCall []struct {
		logger lager.Logger
	}
	allVirtualGuestsReturns struct {
		result1 []*models.VM
		result2 error
	}
	VirtualGuestsStub        func(logger lager.Logger, publicVlan, privateVlan, cpu, memory_mb int32, state models.State) ([]*models.VM, error)
	virtualGuestsMutex       sync.RWMutex
	virtualGuestsArgsForCall []struct {
		logger      lager.Logger
		publicVlan  int32
		privateVlan int32
		cpu         int32
		memory_mb   int32
		state       models.State
	}
	virtualGuestsReturns struct {
		result1 []*models.VM
		result2 error
	}
	OrderVirtualGuestStub        func(logger lager.Logger, vmFilter *models.VMFilter) (*models.VM, error)
	orderVirtualGuestMutex       sync.RWMutex
	orderVirtualGuestArgsForCall []struct {
		logger   lager.Logger
		vmFilter *models.VMFilter
	}
	orderVirtualGuestReturns struct {
		result1 *models.VM
		result2 error
	}
	VirtualGuestsByDeploymentsStub        func(logger lager.Logger, names []string) ([]*models.VM, error)
	virtualGuestsByDeploymentsMutex       sync.RWMutex
	virtualGuestsByDeploymentsArgsForCall []struct {
		logger lager.Logger
		names  []string
	}
	virtualGuestsByDeploymentsReturns struct {
		result1 []*models.VM
		result2 error
	}
	VirtualGuestsByStatesStub        func(logger lager.Logger, states []string) ([]*models.VM, error)
	virtualGuestsByStatesMutex       sync.RWMutex
	virtualGuestsByStatesArgsForCall []struct {
		logger lager.Logger
		states []string
	}
	virtualGuestsByStatesReturns struct {
		result1 []*models.VM
		result2 error
	}
	CreateVMStub        func(logger lager.Logger, vm *models.VM) error
	createVMMutex       sync.RWMutex
	createVMArgsForCall []struct {
		logger lager.Logger
		vm     *models.VM
	}
	createVMReturns struct {
		result1 error
	}
	DeleteVMStub        func(logger lager.Logger, cid int32) error
	deleteVMMutex       sync.RWMutex
	deleteVMArgsForCall []struct {
		logger lager.Logger
		cid    int32
	}
	deleteVMReturns struct {
		result1 error
	}
	UpdateVMStub        func(logger lager.Logger, vm *models.VM) error
	updateVMMutex       sync.RWMutex
	updateVMArgsForCall []struct {
		logger lager.Logger
		vm     *models.VM
	}
	updateVMReturns struct {
		result1 error
	}
	UpdateVMWithStateStub        func(logger lager.Logger, cid int32, updateData *models.State) error
	updateVMWithStateMutex       sync.RWMutex
	updateVMWithStateArgsForCall []struct {
		logger     lager.Logger
		cid        int32
		updateData *models.State
	}
	updateVMWithStateReturns struct {
		result1 error
	}
	VirtualGuestByCidStub        func(logger lager.Logger, cid int32) (*models.VM, error)
	virtualGuestByCidMutex       sync.RWMutex
	virtualGuestByCidArgsForCall []struct {
		logger lager.Logger
		cid    int32
	}
	virtualGuestByCidReturns struct {
		result1 *models.VM
		result2 error
	}
	invocations      map[string][][]interface{}
	invocationsMutex sync.RWMutex
}

func (fake *FakeVirtualGuestController) AllVirtualGuests(logger lager.Logger) ([]*models.VM, error) {
	fake.allVirtualGuestsMutex.Lock()
	fake.allVirtualGuestsArgsForCall = append(fake.allVirtualGuestsArgsForCall, struct {
		logger lager.Logger
	}{logger})
	fake.recordInvocation("AllVirtualGuests", []interface{}{logger})
	fake.allVirtualGuestsMutex.Unlock()
	if fake.AllVirtualGuestsStub != nil {
		return fake.AllVirtualGuestsStub(logger)
	} else {
		return fake.allVirtualGuestsReturns.result1, fake.allVirtualGuestsReturns.result2
	}
}

func (fake *FakeVirtualGuestController) AllVirtualGuestsCallCount() int {
	fake.allVirtualGuestsMutex.RLock()
	defer fake.allVirtualGuestsMutex.RUnlock()
	return len(fake.allVirtualGuestsArgsForCall)
}

func (fake *FakeVirtualGuestController) AllVirtualGuestsArgsForCall(i int) lager.Logger {
	fake.allVirtualGuestsMutex.RLock()
	defer fake.allVirtualGuestsMutex.RUnlock()
	return fake.allVirtualGuestsArgsForCall[i].logger
}

func (fake *FakeVirtualGuestController) AllVirtualGuestsReturns(result1 []*models.VM, result2 error) {
	fake.AllVirtualGuestsStub = nil
	fake.allVirtualGuestsReturns = struct {
		result1 []*models.VM
		result2 error
	}{result1, result2}
}

func (fake *FakeVirtualGuestController) VirtualGuests(logger lager.Logger, publicVlan int32, privateVlan int32, cpu int32, memory_mb int32, state models.State) ([]*models.VM, error) {
	fake.virtualGuestsMutex.Lock()
	fake.virtualGuestsArgsForCall = append(fake.virtualGuestsArgsForCall, struct {
		logger      lager.Logger
		publicVlan  int32
		privateVlan int32
		cpu         int32
		memory_mb   int32
		state       models.State
	}{logger, publicVlan, privateVlan, cpu, memory_mb, state})
	fake.recordInvocation("VirtualGuests", []interface{}{logger, publicVlan, privateVlan, cpu, memory_mb, state})
	fake.virtualGuestsMutex.Unlock()
	if fake.VirtualGuestsStub != nil {
		return fake.VirtualGuestsStub(logger, publicVlan, privateVlan, cpu, memory_mb, state)
	} else {
		return fake.virtualGuestsReturns.result1, fake.virtualGuestsReturns.result2
	}
}

func (fake *FakeVirtualGuestController) VirtualGuestsCallCount() int {
	fake.virtualGuestsMutex.RLock()
	defer fake.virtualGuestsMutex.RUnlock()
	return len(fake.virtualGuestsArgsForCall)
}

func (fake *FakeVirtualGuestController) VirtualGuestsArgsForCall(i int) (lager.Logger, int32, int32, int32, int32, models.State) {
	fake.virtualGuestsMutex.RLock()
	defer fake.virtualGuestsMutex.RUnlock()
	return fake.virtualGuestsArgsForCall[i].logger, fake.virtualGuestsArgsForCall[i].publicVlan, fake.virtualGuestsArgsForCall[i].privateVlan, fake.virtualGuestsArgsForCall[i].cpu, fake.virtualGuestsArgsForCall[i].memory_mb, fake.virtualGuestsArgsForCall[i].state
}

func (fake *FakeVirtualGuestController) VirtualGuestsReturns(result1 []*models.VM, result2 error) {
	fake.VirtualGuestsStub = nil
	fake.virtualGuestsReturns = struct {
		result1 []*models.VM
		result2 error
	}{result1, result2}
}

func (fake *FakeVirtualGuestController) OrderVirtualGuest(logger lager.Logger, vmFilter *models.VMFilter) (*models.VM, error) {
	fake.orderVirtualGuestMutex.Lock()
	fake.orderVirtualGuestArgsForCall = append(fake.orderVirtualGuestArgsForCall, struct {
		logger   lager.Logger
		vmFilter *models.VMFilter
	}{logger, vmFilter})
	fake.recordInvocation("OrderVirtualGuest", []interface{}{logger, vmFilter})
	fake.orderVirtualGuestMutex.Unlock()
	if fake.OrderVirtualGuestStub != nil {
		return fake.OrderVirtualGuestStub(logger, vmFilter)
	} else {
		return fake.orderVirtualGuestReturns.result1, fake.orderVirtualGuestReturns.result2
	}
}

func (fake *FakeVirtualGuestController) OrderVirtualGuestCallCount() int {
	fake.orderVirtualGuestMutex.RLock()
	defer fake.orderVirtualGuestMutex.RUnlock()
	return len(fake.orderVirtualGuestArgsForCall)
}

func (fake *FakeVirtualGuestController) OrderVirtualGuestArgsForCall(i int) (lager.Logger, *models.VMFilter) {
	fake.orderVirtualGuestMutex.RLock()
	defer fake.orderVirtualGuestMutex.RUnlock()
	return fake.orderVirtualGuestArgsForCall[i].logger, fake.orderVirtualGuestArgsForCall[i].vmFilter
}

func (fake *FakeVirtualGuestController) OrderVirtualGuestReturns(result1 *models.VM, result2 error) {
	fake.OrderVirtualGuestStub = nil
	fake.orderVirtualGuestReturns = struct {
		result1 *models.VM
		result2 error
	}{result1, result2}
}

func (fake *FakeVirtualGuestController) VirtualGuestsByDeployments(logger lager.Logger, names []string) ([]*models.VM, error) {
	var namesCopy []string
	if names != nil {
		namesCopy = make([]string, len(names))
		copy(namesCopy, names)
	}
	fake.virtualGuestsByDeploymentsMutex.Lock()
	fake.virtualGuestsByDeploymentsArgsForCall = append(fake.virtualGuestsByDeploymentsArgsForCall, struct {
		logger lager.Logger
		names  []string
	}{logger, namesCopy})
	fake.recordInvocation("VirtualGuestsByDeployments", []interface{}{logger, namesCopy})
	fake.virtualGuestsByDeploymentsMutex.Unlock()
	if fake.VirtualGuestsByDeploymentsStub != nil {
		return fake.VirtualGuestsByDeploymentsStub(logger, names)
	} else {
		return fake.virtualGuestsByDeploymentsReturns.result1, fake.virtualGuestsByDeploymentsReturns.result2
	}
}

func (fake *FakeVirtualGuestController) VirtualGuestsByDeploymentsCallCount() int {
	fake.virtualGuestsByDeploymentsMutex.RLock()
	defer fake.virtualGuestsByDeploymentsMutex.RUnlock()
	return len(fake.virtualGuestsByDeploymentsArgsForCall)
}

func (fake *FakeVirtualGuestController) VirtualGuestsByDeploymentsArgsForCall(i int) (lager.Logger, []string) {
	fake.virtualGuestsByDeploymentsMutex.RLock()
	defer fake.virtualGuestsByDeploymentsMutex.RUnlock()
	return fake.virtualGuestsByDeploymentsArgsForCall[i].logger, fake.virtualGuestsByDeploymentsArgsForCall[i].names
}

func (fake *FakeVirtualGuestController) VirtualGuestsByDeploymentsReturns(result1 []*models.VM, result2 error) {
	fake.VirtualGuestsByDeploymentsStub = nil
	fake.virtualGuestsByDeploymentsReturns = struct {
		result1 []*models.VM
		result2 error
	}{result1, result2}
}

func (fake *FakeVirtualGuestController) VirtualGuestsByStates(logger lager.Logger, states []string) ([]*models.VM, error) {
	var statesCopy []string
	if states != nil {
		statesCopy = make([]string, len(states))
		copy(statesCopy, states)
	}
	fake.virtualGuestsByStatesMutex.Lock()
	fake.virtualGuestsByStatesArgsForCall = append(fake.virtualGuestsByStatesArgsForCall, struct {
		logger lager.Logger
		states []string
	}{logger, statesCopy})
	fake.recordInvocation("VirtualGuestsByStates", []interface{}{logger, statesCopy})
	fake.virtualGuestsByStatesMutex.Unlock()
	if fake.VirtualGuestsByStatesStub != nil {
		return fake.VirtualGuestsByStatesStub(logger, states)
	} else {
		return fake.virtualGuestsByStatesReturns.result1, fake.virtualGuestsByStatesReturns.result2
	}
}

func (fake *FakeVirtualGuestController) VirtualGuestsByStatesCallCount() int {
	fake.virtualGuestsByStatesMutex.RLock()
	defer fake.virtualGuestsByStatesMutex.RUnlock()
	return len(fake.virtualGuestsByStatesArgsForCall)
}

func (fake *FakeVirtualGuestController) VirtualGuestsByStatesArgsForCall(i int) (lager.Logger, []string) {
	fake.virtualGuestsByStatesMutex.RLock()
	defer fake.virtualGuestsByStatesMutex.RUnlock()
	return fake.virtualGuestsByStatesArgsForCall[i].logger, fake.virtualGuestsByStatesArgsForCall[i].states
}

func (fake *FakeVirtualGuestController) VirtualGuestsByStatesReturns(result1 []*models.VM, result2 error) {
	fake.VirtualGuestsByStatesStub = nil
	fake.virtualGuestsByStatesReturns = struct {
		result1 []*models.VM
		result2 error
	}{result1, result2}
}

func (fake *FakeVirtualGuestController) CreateVM(logger lager.Logger, vm *models.VM) error {
	fake.createVMMutex.Lock()
	fake.createVMArgsForCall = append(fake.createVMArgsForCall, struct {
		logger lager.Logger
		vm     *models.VM
	}{logger, vm})
	fake.recordInvocation("CreateVM", []interface{}{logger, vm})
	fake.createVMMutex.Unlock()
	if fake.CreateVMStub != nil {
		return fake.CreateVMStub(logger, vm)
	} else {
		return fake.createVMReturns.result1
	}
}

func (fake *FakeVirtualGuestController) CreateVMCallCount() int {
	fake.createVMMutex.RLock()
	defer fake.createVMMutex.RUnlock()
	return len(fake.createVMArgsForCall)
}

func (fake *FakeVirtualGuestController) CreateVMArgsForCall(i int) (lager.Logger, *models.VM) {
	fake.createVMMutex.RLock()
	defer fake.createVMMutex.RUnlock()
	return fake.createVMArgsForCall[i].logger, fake.createVMArgsForCall[i].vm
}

func (fake *FakeVirtualGuestController) CreateVMReturns(result1 error) {
	fake.CreateVMStub = nil
	fake.createVMReturns = struct {
		result1 error
	}{result1}
}

func (fake *FakeVirtualGuestController) DeleteVM(logger lager.Logger, cid int32) error {
	fake.deleteVMMutex.Lock()
	fake.deleteVMArgsForCall = append(fake.deleteVMArgsForCall, struct {
		logger lager.Logger
		cid    int32
	}{logger, cid})
	fake.recordInvocation("DeleteVM", []interface{}{logger, cid})
	fake.deleteVMMutex.Unlock()
	if fake.DeleteVMStub != nil {
		return fake.DeleteVMStub(logger, cid)
	} else {
		return fake.deleteVMReturns.result1
	}
}

func (fake *FakeVirtualGuestController) DeleteVMCallCount() int {
	fake.deleteVMMutex.RLock()
	defer fake.deleteVMMutex.RUnlock()
	return len(fake.deleteVMArgsForCall)
}

func (fake *FakeVirtualGuestController) DeleteVMArgsForCall(i int) (lager.Logger, int32) {
	fake.deleteVMMutex.RLock()
	defer fake.deleteVMMutex.RUnlock()
	return fake.deleteVMArgsForCall[i].logger, fake.deleteVMArgsForCall[i].cid
}

func (fake *FakeVirtualGuestController) DeleteVMReturns(result1 error) {
	fake.DeleteVMStub = nil
	fake.deleteVMReturns = struct {
		result1 error
	}{result1}
}

func (fake *FakeVirtualGuestController) UpdateVM(logger lager.Logger, vm *models.VM) error {
	fake.updateVMMutex.Lock()
	fake.updateVMArgsForCall = append(fake.updateVMArgsForCall, struct {
		logger lager.Logger
		vm     *models.VM
	}{logger, vm})
	fake.recordInvocation("UpdateVM", []interface{}{logger, vm})
	fake.updateVMMutex.Unlock()
	if fake.UpdateVMStub != nil {
		return fake.UpdateVMStub(logger, vm)
	} else {
		return fake.updateVMReturns.result1
	}
}

func (fake *FakeVirtualGuestController) UpdateVMCallCount() int {
	fake.updateVMMutex.RLock()
	defer fake.updateVMMutex.RUnlock()
	return len(fake.updateVMArgsForCall)
}

func (fake *FakeVirtualGuestController) UpdateVMArgsForCall(i int) (lager.Logger, *models.VM) {
	fake.updateVMMutex.RLock()
	defer fake.updateVMMutex.RUnlock()
	return fake.updateVMArgsForCall[i].logger, fake.updateVMArgsForCall[i].vm
}

func (fake *FakeVirtualGuestController) UpdateVMReturns(result1 error) {
	fake.UpdateVMStub = nil
	fake.updateVMReturns = struct {
		result1 error
	}{result1}
}

func (fake *FakeVirtualGuestController) UpdateVMWithState(logger lager.Logger, cid int32, updateData *models.State) error {
	fake.updateVMWithStateMutex.Lock()
	fake.updateVMWithStateArgsForCall = append(fake.updateVMWithStateArgsForCall, struct {
		logger     lager.Logger
		cid        int32
		updateData *models.State
	}{logger, cid, updateData})
	fake.recordInvocation("UpdateVMWithState", []interface{}{logger, cid, updateData})
	fake.updateVMWithStateMutex.Unlock()
	if fake.UpdateVMWithStateStub != nil {
		return fake.UpdateVMWithStateStub(logger, cid, updateData)
	} else {
		return fake.updateVMWithStateReturns.result1
	}
}

func (fake *FakeVirtualGuestController) UpdateVMWithStateCallCount() int {
	fake.updateVMWithStateMutex.RLock()
	defer fake.updateVMWithStateMutex.RUnlock()
	return len(fake.updateVMWithStateArgsForCall)
}

func (fake *FakeVirtualGuestController) UpdateVMWithStateArgsForCall(i int) (lager.Logger, int32, *models.State) {
	fake.updateVMWithStateMutex.RLock()
	defer fake.updateVMWithStateMutex.RUnlock()
	return fake.updateVMWithStateArgsForCall[i].logger, fake.updateVMWithStateArgsForCall[i].cid, fake.updateVMWithStateArgsForCall[i].updateData
}

func (fake *FakeVirtualGuestController) UpdateVMWithStateReturns(result1 error) {
	fake.UpdateVMWithStateStub = nil
	fake.updateVMWithStateReturns = struct {
		result1 error
	}{result1}
}

func (fake *FakeVirtualGuestController) VirtualGuestByCid(logger lager.Logger, cid int32) (*models.VM, error) {
	fake.virtualGuestByCidMutex.Lock()
	fake.virtualGuestByCidArgsForCall = append(fake.virtualGuestByCidArgsForCall, struct {
		logger lager.Logger
		cid    int32
	}{logger, cid})
	fake.recordInvocation("VirtualGuestByCid", []interface{}{logger, cid})
	fake.virtualGuestByCidMutex.Unlock()
	if fake.VirtualGuestByCidStub != nil {
		return fake.VirtualGuestByCidStub(logger, cid)
	} else {
		return fake.virtualGuestByCidReturns.result1, fake.virtualGuestByCidReturns.result2
	}
}

func (fake *FakeVirtualGuestController) VirtualGuestByCidCallCount() int {
	fake.virtualGuestByCidMutex.RLock()
	defer fake.virtualGuestByCidMutex.RUnlock()
	return len(fake.virtualGuestByCidArgsForCall)
}

func (fake *FakeVirtualGuestController) VirtualGuestByCidArgsForCall(i int) (lager.Logger, int32) {
	fake.virtualGuestByCidMutex.RLock()
	defer fake.virtualGuestByCidMutex.RUnlock()
	return fake.virtualGuestByCidArgsForCall[i].logger, fake.virtualGuestByCidArgsForCall[i].cid
}

func (fake *FakeVirtualGuestController) VirtualGuestByCidReturns(result1 *models.VM, result2 error) {
	fake.VirtualGuestByCidStub = nil
	fake.virtualGuestByCidReturns = struct {
		result1 *models.VM
		result2 error
	}{result1, result2}
}

func (fake *FakeVirtualGuestController) Invocations() map[string][][]interface{} {
	fake.invocationsMutex.RLock()
	defer fake.invocationsMutex.RUnlock()
	fake.allVirtualGuestsMutex.RLock()
	defer fake.allVirtualGuestsMutex.RUnlock()
	fake.virtualGuestsMutex.RLock()
	defer fake.virtualGuestsMutex.RUnlock()
	fake.orderVirtualGuestMutex.RLock()
	defer fake.orderVirtualGuestMutex.RUnlock()
	fake.virtualGuestsByDeploymentsMutex.RLock()
	defer fake.virtualGuestsByDeploymentsMutex.RUnlock()
	fake.virtualGuestsByStatesMutex.RLock()
	defer fake.virtualGuestsByStatesMutex.RUnlock()
	fake.createVMMutex.RLock()
	defer fake.createVMMutex.RUnlock()
	fake.deleteVMMutex.RLock()
	defer fake.deleteVMMutex.RUnlock()
	fake.updateVMMutex.RLock()
	defer fake.updateVMMutex.RUnlock()
	fake.updateVMWithStateMutex.RLock()
	defer fake.updateVMWithStateMutex.RUnlock()
	fake.virtualGuestByCidMutex.RLock()
	defer fake.virtualGuestByCidMutex.RUnlock()
	return fake.invocations
}

func (fake *FakeVirtualGuestController) recordInvocation(key string, args []interface{}) {
	fake.invocationsMutex.Lock()
	defer fake.invocationsMutex.Unlock()
	if fake.invocations == nil {
		fake.invocations = map[string][][]interface{}{}
	}
	if fake.invocations[key] == nil {
		fake.invocations[key] = [][]interface{}{}
	}
	fake.invocations[key] = append(fake.invocations[key], args)
}

var _ handlers.VirtualGuestController = new(FakeVirtualGuestController)
