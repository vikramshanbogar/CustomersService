package com.vikram.customers.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class CustomerExceptionHandler {

    @ExceptionHandler(value = {CustomerNotFoundException.class})
    public ResponseEntity<Object> handleCloudVendorNotFoundException
            (CustomerNotFoundException cloudVendorNotFoundException)
    {
//        CloudVendorException cloudVendorException = new CloudVendorException(
//                cloudVendorNotFoundException.getMessage(),
//                cloudVendorNotFoundException.getCause(),
//                HttpStatus.NOT_FOUND
//        );

        return new ResponseEntity<>(cloudVendorNotFoundException, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(value = {CustomerException.class})
    public ResponseEntity<Object> handleCustomerNotFoundException
            (CustomerException customerException)
    {
        ErrorResponse cloudVendorException = new ErrorResponse(
                customerException.getMessage(),
                customerException.getCause(),
                HttpStatus.BAD_REQUEST
        );

        return new ResponseEntity<>(cloudVendorException, HttpStatus.NOT_FOUND);
    }


    @ExceptionHandler(value = {Exception.class})
    public ResponseEntity<Object> generic
            (Exception customerException)
    {
        ErrorResponse cloudVendorException = new ErrorResponse(
                "Generic",
                customerException.getCause(),
                HttpStatus.CREATED
        );

        return new ResponseEntity<>(cloudVendorException, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler({RuntimeException.class})
    public ResponseEntity<Object> handleRuntimeException(RuntimeException exception) {
        return ResponseEntity
                .status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(exception.getMessage());
    }
}