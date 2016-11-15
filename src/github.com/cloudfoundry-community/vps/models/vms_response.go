package models

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	strfmt "github.com/go-openapi/strfmt"
	"github.com/go-openapi/swag"

	"github.com/go-openapi/errors"
)

// VmsResponse vms response
// swagger:model VmsResponse
type VmsResponse struct {

	// vms
	Vms []*VM `json:"vms"`
}

// Validate validates this vms response
func (m *VmsResponse) Validate(formats strfmt.Registry) error {
	var res []error

	if err := m.validateVms(formats); err != nil {
		// prop
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

func (m *VmsResponse) validateVms(formats strfmt.Registry) error {

	if swag.IsZero(m.Vms) { // not required
		return nil
	}

	for i := 0; i < len(m.Vms); i++ {

		if swag.IsZero(m.Vms[i]) { // not required
			continue
		}

		if m.Vms[i] != nil {

			if err := m.Vms[i].Validate(formats); err != nil {
				return err
			}
		}

	}

	return nil
}
