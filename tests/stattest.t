-- WARNING: any changes to this file need to change this constant to match!
local stattest_t_file_size = 463

-- Windows doesn't have stat() and FreeBSD's version of struct stat uses
--  bit fields, which terra doesn't seem to handle
if terralib.os == "Windows" or terralib.os == "BSD" then
  return
end

C,T = terralib.includec("sys/stat.h")
terra dostat()
	var s : T.stat
	C.stat("stattest.t",&s)
	return s.st_size
end

assert(dostat() == stattest_t_file_size)
