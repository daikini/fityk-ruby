%module "fityk::driver::native::API"

%{
#include "fityk.h"
#define Init_API Init_fityk_api
%}
%include "std_string.i"
%include "std_vector.i"
%include "std_except.i"
namespace std {
        %template(PointVector) vector<fityk::Point>;
        %template(DoubleVector) vector<double>;
}

%rename(__str__) str();

%ignore set_show_message;

%include "fityk.h"

%extend fityk::ExecuteError 
{
        const char* __str__() { return $self->what(); }
};

%extend fityk::SyntaxError 
{
        const char* __str__() { return ""; }
};
