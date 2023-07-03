// Code generated by moq; DO NOT EDIT.
// github.com/matryer/moq

package controllers

import (
	"github.com/versity/versitygw/auth"
	"sync"
)

// Ensure, that IAMServiceMock does implement auth.IAMService.
// If this is not the case, regenerate this file with moq.
var _ auth.IAMService = &IAMServiceMock{}

// IAMServiceMock is a mock implementation of auth.IAMService.
//
//	func TestSomethingThatUsesIAMService(t *testing.T) {
//
//		// make and configure a mocked auth.IAMService
//		mockedIAMService := &IAMServiceMock{
//			CreateAccountFunc: func(access string, account auth.Account) error {
//				panic("mock out the CreateAccount method")
//			},
//			DeleteUserAccountFunc: func(access string) error {
//				panic("mock out the DeleteUserAccount method")
//			},
//			GetUserAccountFunc: func(access string) (auth.Account, error) {
//				panic("mock out the GetUserAccount method")
//			},
//		}
//
//		// use mockedIAMService in code that requires auth.IAMService
//		// and then make assertions.
//
//	}
type IAMServiceMock struct {
	// CreateAccountFunc mocks the CreateAccount method.
	CreateAccountFunc func(access string, account auth.Account) error

	// DeleteUserAccountFunc mocks the DeleteUserAccount method.
	DeleteUserAccountFunc func(access string) error

	// GetUserAccountFunc mocks the GetUserAccount method.
	GetUserAccountFunc func(access string) (auth.Account, error)

	// calls tracks calls to the methods.
	calls struct {
		// CreateAccount holds details about calls to the CreateAccount method.
		CreateAccount []struct {
			// Access is the access argument value.
			Access string
			// Account is the account argument value.
			Account auth.Account
		}
		// DeleteUserAccount holds details about calls to the DeleteUserAccount method.
		DeleteUserAccount []struct {
			// Access is the access argument value.
			Access string
		}
		// GetUserAccount holds details about calls to the GetUserAccount method.
		GetUserAccount []struct {
			// Access is the access argument value.
			Access string
		}
	}
	lockCreateAccount     sync.RWMutex
	lockDeleteUserAccount sync.RWMutex
	lockGetUserAccount    sync.RWMutex
}

// CreateAccount calls CreateAccountFunc.
func (mock *IAMServiceMock) CreateAccount(access string, account auth.Account) error {
	if mock.CreateAccountFunc == nil {
		panic("IAMServiceMock.CreateAccountFunc: method is nil but IAMService.CreateAccount was just called")
	}
	callInfo := struct {
		Access  string
		Account auth.Account
	}{
		Access:  access,
		Account: account,
	}
	mock.lockCreateAccount.Lock()
	mock.calls.CreateAccount = append(mock.calls.CreateAccount, callInfo)
	mock.lockCreateAccount.Unlock()
	return mock.CreateAccountFunc(access, account)
}

// CreateAccountCalls gets all the calls that were made to CreateAccount.
// Check the length with:
//
//	len(mockedIAMService.CreateAccountCalls())
func (mock *IAMServiceMock) CreateAccountCalls() []struct {
	Access  string
	Account auth.Account
} {
	var calls []struct {
		Access  string
		Account auth.Account
	}
	mock.lockCreateAccount.RLock()
	calls = mock.calls.CreateAccount
	mock.lockCreateAccount.RUnlock()
	return calls
}

// DeleteUserAccount calls DeleteUserAccountFunc.
func (mock *IAMServiceMock) DeleteUserAccount(access string) error {
	if mock.DeleteUserAccountFunc == nil {
		panic("IAMServiceMock.DeleteUserAccountFunc: method is nil but IAMService.DeleteUserAccount was just called")
	}
	callInfo := struct {
		Access string
	}{
		Access: access,
	}
	mock.lockDeleteUserAccount.Lock()
	mock.calls.DeleteUserAccount = append(mock.calls.DeleteUserAccount, callInfo)
	mock.lockDeleteUserAccount.Unlock()
	return mock.DeleteUserAccountFunc(access)
}

// DeleteUserAccountCalls gets all the calls that were made to DeleteUserAccount.
// Check the length with:
//
//	len(mockedIAMService.DeleteUserAccountCalls())
func (mock *IAMServiceMock) DeleteUserAccountCalls() []struct {
	Access string
} {
	var calls []struct {
		Access string
	}
	mock.lockDeleteUserAccount.RLock()
	calls = mock.calls.DeleteUserAccount
	mock.lockDeleteUserAccount.RUnlock()
	return calls
}

// GetUserAccount calls GetUserAccountFunc.
func (mock *IAMServiceMock) GetUserAccount(access string) (auth.Account, error) {
	if mock.GetUserAccountFunc == nil {
		panic("IAMServiceMock.GetUserAccountFunc: method is nil but IAMService.GetUserAccount was just called")
	}
	callInfo := struct {
		Access string
	}{
		Access: access,
	}
	mock.lockGetUserAccount.Lock()
	mock.calls.GetUserAccount = append(mock.calls.GetUserAccount, callInfo)
	mock.lockGetUserAccount.Unlock()
	return mock.GetUserAccountFunc(access)
}

// GetUserAccountCalls gets all the calls that were made to GetUserAccount.
// Check the length with:
//
//	len(mockedIAMService.GetUserAccountCalls())
func (mock *IAMServiceMock) GetUserAccountCalls() []struct {
	Access string
} {
	var calls []struct {
		Access string
	}
	mock.lockGetUserAccount.RLock()
	calls = mock.calls.GetUserAccount
	mock.lockGetUserAccount.RUnlock()
	return calls
}
