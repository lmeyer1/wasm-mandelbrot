(module
	(memory (import "js" "mem") 1 80 shared)
	(import "console" "log" (func $log (param $value i32)))
	(func (export "mandelbrot") (param $width i32) (param $height i32)
		(local $i i32) (local $j i32)
		(local $ptr i32)
		(local $blue i32)
		i32.const 0
		local.set $blue
		(loop $outer
		i32.const 0
		local.set $i
		(loop $x 

			i32.const 0
			local.set $j
			(loop $y
				local.get $i
				local.get $width
				i32.mul
				local.get $j
				i32.add
				i32.const 4
				i32.mul
				local.tee $ptr
				local.get $i
;;local.get $j
;;call $log
;;local.get $i
;;call $log
				i32.store8
				
				local.get $ptr
				i32.const 1
				i32.add
				local.tee $ptr
				local.get $j
				i32.store8
				
				local.get $ptr
				i32.const 1
				i32.add
				local.tee $ptr
				local.get $blue
				i32.store8
				
				local.get $ptr
				i32.const 1
				i32.add
				local.tee $ptr
				i32.const 0xff
				i32.store8
				
				local.get $j
				i32.const 1
				i32.add
				local.tee $j
				local.get $width
				i32.lt_s
				br_if $y
			)
			
			local.get $i
			i32.const 1
			i32.add
			local.tee $i
			local.get $height
			i32.lt_s
			br_if $x
		)
			local.get $blue
			i32.const 1
			i32.add
			local.set $blue
			br $outer
		)
	)
)