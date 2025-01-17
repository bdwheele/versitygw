// Copyright 2023 Versity Software
// This file is licensed under the Apache License, Version 2.0
// (the "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

package auth

import (
	"errors"
)

// IAMServiceSingle manages the single tenant (root-only) IAM service
type IAMServiceSingle struct{}

var _ IAMService = &IAMServiceSingle{}

var ErrNotSupported = errors.New("method is not supported")

// CreateAccount not valid in single tenant mode
func (IAMServiceSingle) CreateAccount(account Account) error {
	return ErrNotSupported
}

// GetUserAccount no accounts in single tenant mode
func (IAMServiceSingle) GetUserAccount(access string) (Account, error) {
	return Account{}, ErrNoSuchUser
}

// DeleteUserAccount no accounts in single tenant mode
func (IAMServiceSingle) DeleteUserAccount(access string) error {
	return ErrNotSupported
}

// ListUserAccounts no accounts in single tenant mode
func (IAMServiceSingle) ListUserAccounts() ([]Account, error) {
	return []Account{}, nil
}

// Shutdown graceful termination of service
func (IAMServiceSingle) Shutdown() error {
	return nil
}
