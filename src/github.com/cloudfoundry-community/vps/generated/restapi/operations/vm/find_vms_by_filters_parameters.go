package vm

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"net/http"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/runtime"
	"github.com/go-openapi/runtime/middleware"

	"github.com/cloudfoundry-community/vps/generated/models"
)

// NewFindVmsByFiltersParams creates a new FindVmsByFiltersParams object
// with the default values initialized.
func NewFindVmsByFiltersParams() FindVmsByFiltersParams {
	var ()
	return FindVmsByFiltersParams{}
}

// FindVmsByFiltersParams contains all the bound params for the find vms by filters operation
// typically these are obtained from a http.Request
//
// swagger:parameters findVmsByFilters
type FindVmsByFiltersParams struct {

	// HTTP Request Object
	HTTPRequest *http.Request

	/*Vm object that needs to be added to the pool
	  In: body
	*/
	Body *models.VMFilter
}

// BindRequest both binds and validates a request, it assumes that complex things implement a Validatable(strfmt.Registry) error interface
// for simple values it will use straight method calls
func (o *FindVmsByFiltersParams) BindRequest(r *http.Request, route *middleware.MatchedRoute) error {
	var res []error
	o.HTTPRequest = r

	if runtime.HasBody(r) {
		defer r.Body.Close()
		var body models.VMFilter
		if err := route.Consumer.Consume(r.Body, &body); err != nil {
			res = append(res, errors.NewParseError("body", "body", "", err))
		} else {
			if err := body.Validate(route.Formats); err != nil {
				res = append(res, err)
			}

			if len(res) == 0 {
				o.Body = &body
			}
		}

	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}