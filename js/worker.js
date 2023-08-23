var wasm_bytes, wasm_instance
wasm_bytes = fetch("../mandelbrot.wasm")
	.then((response) => response.arrayBuffer())
self.onmessage = (e) => {
	let data = e.data;
	console.log("worker:: data posted from main thread::", data);
	const memsize = data.width * data.height * 4, memchunks = Math.ceil(memsize / 0x10000)
	const memory = new WebAssembly.Memory({initial: memchunks, maximum: memchunks, shared: true})
	console.log(memory.buffer.byteLength)
	postMessage(memory.buffer)
	var importObject = {
		js: {
			mem: memory,
		},
		console: {log: function (value) {
			console.log(value)
		}}
	};
	wasm_bytes.then((bytes) => WebAssembly.instantiate(bytes, importObject))
		.then((results) => {
			wasm_instance = results.instance
			console.log(data.width, data.height)
			console.log(Date.now())
			wasm_instance.exports.mandelbrot(data.width, data.height)
			console.log(Date.now())
		})
};

