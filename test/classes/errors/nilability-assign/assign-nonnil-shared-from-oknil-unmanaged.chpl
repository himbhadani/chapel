//  lhs: shared!  rhs: unmanaged?  errors: nlb, mm

class MyClass {  var x: int;  }

var lhs = new shared MyClass();
var rhs: unmanaged MyClass?;

lhs = rhs;

compilerError("done");

