use Memory;

const targetLocale = Locales[numLocales-1];

var myBytes = b"A Chapel bytes";
startVerboseMem();
on targetLocale {
  // there should be 2 allocations, 2 frees
  writelnNoMem("Initialize from bytes");
  var sNew = createBytesWithNewBuffer(myBytes);
  var sBorrowed = createBytesWithBorrowedBuffer(sNew);
  var sNewFromNew = createBytesWithNewBuffer(sNew);

  writelnNoMem(sNew);
  writelnNoMem(sBorrowed);
  writelnNoMem(sNewFromNew);
}
stopVerboseMem();

writeln();

var cPtrTmp = c_malloc(uint(8), 4);
cPtrTmp[0] = 65:uint(8);
cPtrTmp[1] = 66:uint(8);
cPtrTmp[2] = 67:uint(8);
cPtrTmp[3] = 0:uint(8);
var cStr = cPtrTmp:c_string;
startVerboseMem();
{
  // there should be 1 allocation 1 free
  writelnNoMem("Initialize from c_string");
  var sNew = createBytesWithNewBuffer(cStr);
  var sBorrowed = createBytesWithBorrowedBuffer(cStr);
  var sOwned = createBytesWithOwnedBuffer(cStr);
  /*var sOwned = new string(cStr, isowned=true, needToCopy=false);*/

  writelnNoMem(sNew);
  writelnNoMem(sBorrowed);
  writelnNoMem(sOwned);
}
stopVerboseMem();

writeln();

var cPtr = c_malloc(uint(8), 4);
cPtr[0] = 65:uint(8);
cPtr[1] = 66:uint(8);
cPtr[2] = 67:uint(8);
cPtr[3] = 0:uint(8);
startVerboseMem();
{
  // there should be 1 allocate, 2 frees
  writelnNoMem("Initialize from c_ptr");

  var sNew = createBytesWithNewBuffer(cPtr, length=3, size=4);
  var sBorrowed = createBytesWithBorrowedBuffer(cPtr, length=3, size=4);
  var sOwned = createBytesWithOwnedBuffer(cPtr, length=3, size=4);

  writelnNoMem(sNew);
  writelnNoMem(sBorrowed);
  writelnNoMem(sOwned);

  cPtr[1] = 32:uint(8);

  writelnNoMem(sNew);
  writelnNoMem(sBorrowed);
  writelnNoMem(sOwned);
}
stopVerboseMem();

writeln();

proc writelnNoMem() {
  stopVerboseMem();
  writeln();
  startVerboseMem();
}
proc writelnNoMem(args ...) {
  stopVerboseMem();
  writeln((...args));
  startVerboseMem();
}
