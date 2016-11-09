package operations

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"net/http"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/runtime/middleware"
	"github.com/go-openapi/swag"

	strfmt "github.com/go-openapi/strfmt"
)

// NewPutBaremetalServerIDStateParams creates a new PutBaremetalServerIDStateParams object
// with the default values initialized.
func NewPutBaremetalServerIDStateParams() PutBaremetalServerIDStateParams {
	var ()
	return PutBaremetalServerIDStateParams{}
}

// PutBaremetalServerIDStateParams contains all the bound params for the put baremetal server ID state operation
// typically these are obtained from a http.Request
//
// swagger:parameters PutBaremetalServerIDState
type PutBaremetalServerIDStateParams struct {

	// HTTP Request Object
	HTTPRequest *http.Request

	/*the ID for the server
	  Required: true
	  In: path
	*/
	ServerID int32
	/*the new state for the server
	  Required: true
	  In: path
	*/
	State string
}

// BindRequest both binds and validates a request, it assumes that complex things implement a Validatable(strfmt.Registry) error interface
// for simple values it will use straight method calls
func (o *PutBaremetalServerIDStateParams) BindRequest(r *http.Request, route *middleware.MatchedRoute) error {
	var res []error
	o.HTTPRequest = r

	rServerID, rhkServerID, _ := route.Params.GetOK("serverId")
	if err := o.bindServerID(rServerID, rhkServerID, route.Formats); err != nil {
		res = append(res, err)
	}

	rState, rhkState, _ := route.Params.GetOK("state")
	if err := o.bindState(rState, rhkState, route.Formats); err != nil {
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

func (o *PutBaremetalServerIDStateParams) bindServerID(rawData []string, hasKey bool, formats strfmt.Registry) error {
	var raw string
	if len(rawData) > 0 {
		raw = rawData[len(rawData)-1]
	}

	value, err := swag.ConvertInt32(raw)
	if err != nil {
		return errors.InvalidType("serverId", "path", "int32", raw)
	}
	o.ServerID = value

	return nil
}

func (o *PutBaremetalServerIDStateParams) bindState(rawData []string, hasKey bool, formats strfmt.Registry) error {
	var raw string
	if len(rawData) > 0 {
		raw = rawData[len(rawData)-1]
	}

	o.State = raw

	return nil
}
