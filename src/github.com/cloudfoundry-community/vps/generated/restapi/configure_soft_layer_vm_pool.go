package restapi

import (
	"crypto/tls"
	"net/http"

	errors "github.com/go-openapi/errors"
	runtime "github.com/go-openapi/runtime"
	middleware "github.com/go-openapi/runtime/middleware"

	"github.com/cloudfoundry-community/vps/generated/restapi/operations"
	"github.com/cloudfoundry-community/vps/generated/restapi/operations/vm"
)

// This file is safe to edit. Once it exists it will not be overwritten

//go:generate swagger generate server --target .. --name  --spec ../swagger.json

func configureFlags(api *operations.SoftLayerVMPoolAPI) {
	// api.CommandLineOptionsGroups = []swag.CommandLineOptionsGroup{ ... }
}

func configureAPI(api *operations.SoftLayerVMPoolAPI) http.Handler {
	// configure the api here
	api.ServeError = errors.ServeError

	// Set your custom logger if needed. Default one is log.Printf
	// Expected interface func(string, ...interface{})
	//
	// Example:
	// s.api.Logger = log.Printf

	api.JSONConsumer = runtime.JSONConsumer()

	api.JSONProducer = runtime.JSONProducer()

	api.VMAddVMHandler = vm.AddVMHandlerFunc(func(params vm.AddVMParams) middleware.Responder {
		return middleware.NotImplemented("operation vm.AddVM has not yet been implemented")
	})
	api.VMDeleteVMHandler = vm.DeleteVMHandlerFunc(func(params vm.DeleteVMParams) middleware.Responder {
		return middleware.NotImplemented("operation vm.DeleteVM has not yet been implemented")
	})
	api.VMFindVmsByDeploymentHandler = vm.FindVmsByDeploymentHandlerFunc(func(params vm.FindVmsByDeploymentParams) middleware.Responder {
		return middleware.NotImplemented("operation vm.FindVmsByDeployment has not yet been implemented")
	})
	api.VMFindVmsByFiltersHandler = vm.FindVmsByFiltersHandlerFunc(func(params vm.FindVmsByFiltersParams) middleware.Responder {
		return middleware.NotImplemented("operation vm.FindVmsByFilters has not yet been implemented")
	})
	api.VMFindVmsByStatesHandler = vm.FindVmsByStatesHandlerFunc(func(params vm.FindVmsByStatesParams) middleware.Responder {
		return middleware.NotImplemented("operation vm.FindVmsByStates has not yet been implemented")
	})
	api.VMGetVMByCidHandler = vm.GetVMByCidHandlerFunc(func(params vm.GetVMByCidParams) middleware.Responder {
		return middleware.NotImplemented("operation vm.GetVMByCid has not yet been implemented")
	})
	api.VMListVMHandler = vm.ListVMHandlerFunc(func(params vm.ListVMParams) middleware.Responder {
		return middleware.NotImplemented("operation vm.ListVM has not yet been implemented")
	})
	api.VMOrderVMByFilterHandler = vm.OrderVMByFilterHandlerFunc(func(params vm.OrderVMByFilterParams) middleware.Responder {
		return middleware.NotImplemented("operation vm.OrderVMByFilter has not yet been implemented")
	})
	api.VMUpdateVMHandler = vm.UpdateVMHandlerFunc(func(params vm.UpdateVMParams) middleware.Responder {
		return middleware.NotImplemented("operation vm.UpdateVM has not yet been implemented")
	})
	api.VMUpdateVMWithStateHandler = vm.UpdateVMWithStateHandlerFunc(func(params vm.UpdateVMWithStateParams) middleware.Responder {
		return middleware.NotImplemented("operation vm.UpdateVMWithState has not yet been implemented")
	})

	api.ServerShutdown = func() {}

	return setupGlobalMiddleware(api.Serve(setupMiddlewares))
}

// The TLS configuration before HTTPS server starts.
func configureTLS(tlsConfig *tls.Config) {
	// Make all necessary changes to the TLS configuration here.
}

// The middleware configuration is for the handler executors. These do not apply to the swagger.json document.
// The middleware executes after routing but before authentication, binding and validation
func setupMiddlewares(handler http.Handler) http.Handler {
	return handler
}

// The middleware configuration happens before anything, this middleware also applies to serving the swagger.json document.
// So this is a good place to plug in a panic handling middleware, logging and metrics
func setupGlobalMiddleware(handler http.Handler) http.Handler {
	return handler
}
