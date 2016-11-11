package operations

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"net/http"

	"github.com/go-openapi/runtime"

	"github.com/cloudfoundry-community/bms/models"
)

/*GetStemcellsOK Successful response

swagger:response getStemcellsOK
*/
type GetStemcellsOK struct {

	// In: body
	Payload *models.Stemcells `json:"body,omitempty"`
}

// NewGetStemcellsOK creates GetStemcellsOK with default headers values
func NewGetStemcellsOK() *GetStemcellsOK {
	return &GetStemcellsOK{}
}

// WithPayload adds the payload to the get stemcells o k response
func (o *GetStemcellsOK) WithPayload(payload *models.Stemcells) *GetStemcellsOK {
	o.Payload = payload
	return o
}

// SetPayload sets the payload to the get stemcells o k response
func (o *GetStemcellsOK) SetPayload(payload *models.Stemcells) {
	o.Payload = payload
}

// WriteResponse to the client
func (o *GetStemcellsOK) WriteResponse(rw http.ResponseWriter, producer runtime.Producer) {

	rw.WriteHeader(200)
	if o.Payload != nil {
		if err := producer.Produce(rw, o.Payload); err != nil {
			panic(err) // let the recovery middleware deal with this
		}
	}
}

/*GetStemcellsDefault Unexpected error

swagger:response getStemcellsDefault
*/
type GetStemcellsDefault struct {
	_statusCode int

	// In: body
	Payload *models.Error `json:"body,omitempty"`
}

// NewGetStemcellsDefault creates GetStemcellsDefault with default headers values
func NewGetStemcellsDefault(code int) *GetStemcellsDefault {
	if code <= 0 {
		code = 500
	}

	return &GetStemcellsDefault{
		_statusCode: code,
	}
}

// WithStatusCode adds the status to the get stemcells default response
func (o *GetStemcellsDefault) WithStatusCode(code int) *GetStemcellsDefault {
	o._statusCode = code
	return o
}

// SetStatusCode sets the status to the get stemcells default response
func (o *GetStemcellsDefault) SetStatusCode(code int) {
	o._statusCode = code
}

// WithPayload adds the payload to the get stemcells default response
func (o *GetStemcellsDefault) WithPayload(payload *models.Error) *GetStemcellsDefault {
	o.Payload = payload
	return o
}

// SetPayload sets the payload to the get stemcells default response
func (o *GetStemcellsDefault) SetPayload(payload *models.Error) {
	o.Payload = payload
}

// WriteResponse to the client
func (o *GetStemcellsDefault) WriteResponse(rw http.ResponseWriter, producer runtime.Producer) {

	rw.WriteHeader(o._statusCode)
	if o.Payload != nil {
		if err := producer.Produce(rw, o.Payload); err != nil {
			panic(err) // let the recovery middleware deal with this
		}
	}
}
