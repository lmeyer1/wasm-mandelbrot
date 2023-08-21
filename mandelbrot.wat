(module
	(memory (import "js" "mem") 1)
	(import "console" "log" (func $log (param $id i32) (param $value i32)))
	(func (export "mandelbrot")
		(local $i i32) (local $j i32)
		(local $ptr i32)
		i32.const 0
		local.set $i
		(loop $x 

			i32.const 0
			local.set $j
			(loop $y
				local.get $i
				i32.const 256
				i32.mul
				local.get $j
				i32.add
				i32.const 4
				i32.mul
				local.tee $ptr
				local.get $i
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
				i32.const 65407 ;; 255×256+127  127 bleu 255 alpha
				i32.store16
				
				local.get $j
				i32.const 1
				i32.add
				local.tee $j
				i32.const 255
				i32.lt_s
				br_if $y
			)
			
			local.get $i
			i32.const 1
			i32.add
			local.tee $i
			i32.const 255
			i32.lt_s
			br_if $x
		)
	)
)