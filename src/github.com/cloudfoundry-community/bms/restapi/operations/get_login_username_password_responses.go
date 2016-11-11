package operations

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"net/http"

	"github.com/go-openapi/runtime"

	"github.com/cloudfoundry-community/bms/models"
)

/*GetLoginUsernamePasswordOK Successful response

swagger:response getLoginUsernamePasswordOK
*/
type GetLoginUsernamePasswordOK struct {

	// In: body
	Payload *models.Login `json:"body,omitempty"`
}

// NewGetLoginUsernamePasswordOK creates GetLoginUsernamePasswordOK with default headers values
func NewGetLoginUsernamePasswordOK() *GetLoginUsernamePasswordOK {
	return &GetLoginUsernamePasswordOK{}
}

// WithPayload adds the payload to the get login username password o k response
func (o *GetLoginUsernamePasswordOK) WithPayload(payload *models.Login) *GetLoginUsernamePasswordOK {
	o.Payload = payload
	return o
}

// SetPayload sets the payload to the get login username password o k response
func (o *GetLoginUsernamePasswordOK) SetPayload(payload *models.Login) {
	o.Payload = payload
}

// WriteResponse to the client
func (o *GetLoginUsernamePasswordOK) WriteResponse(rw http.ResponseWriter, producer runtime.Producer) {

	rw.WriteHeader(200)
	if o.Payload != nil {
		if err := producer.Produce(rw, o.Payload); err != nil {
			panic(err) // let the recovery middleware deal with this
		}
	}
}

/*GetLoginUsernamePasswordDefault Unexpected error

swagger:response getLoginUsernamePasswordDefault
*/
type GetLoginUsernamePasswordDefault struct {
	_statusCode int

	// In: body
	Payload *models.Error `json:"body,omitempty"`
}

// NewGetLoginUsernamePasswordDefault creates GetLoginUsernamePasswordDefault with default headers values
func NewGetLoginUsernamePasswordDefault(code int) *GetLoginUsernamePasswordDefault {
	if code <= 0 {
		code = 500
	}

	return &GetLoginUsernamePasswordDefault{
		_statusCode: code,
	}
}

// WithStatusCode adds the status to the get login username password default response
func (o *GetLoginUsernamePasswordDefault) WithStatusCode(code int) *GetLoginUsernamePasswordDefault {
	o._statusCode = code
	return o
}

// SetStatusCode sets the status to the get login username password default response
func (o *GetLoginUsernamePasswordDefault) SetStatusCode(code int) {
	o._statusCode = code
}

// WithPayload adds the payload to the get login username password default response
func (o *GetLoginUsernamePasswordDefault) WithPayload(payload *models.Error) *GetLoginUsernamePasswordDefault {
	o.Payload = payload
	return o
}

// SetPayload sets the payload to the get login username password default response
func (o *GetLoginUsernamePasswordDefault) SetPayload(payload *models.Error) {
	o.Payload = payload
}

// WriteResponse to the client
func (o *GetLoginUsernamePasswordDefault) WriteResponse(rw http.ResponseWriter, producer runtime.Producer) {

	rw.WriteHeader(o._statusCode)
	if o.Payload != nil {
		if err := producer.Produce(rw, o.Payload); err != nil {
			panic(err) // let the recovery middleware deal with this
		}
	}
}
