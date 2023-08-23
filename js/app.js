var ctx, imageArray, width, height
document.addEventListener("DOMContentLoaded", function(event) {
	const canvas = document.getElementById("canvas");
	width = canvas.width
	height = canvas.height
	const workerInstance = new Worker("./js/worker.php");

	workerInstance.onmessage = (e) => {
		console.log("Worker said: ", e.data);
		const sharedbuffer = e.data
		ctx = canvas.getContext("2d");
		console.log(sharedbuffer.byteLength)
		const imageArray = new Uint8ClampedArray(sharedbuffer, 0, width * height * 4)
		console.log(imageArray.byteLength)
		function updateCanvas() {
			console.log(imageArray.byteLength, imageArray.slice(0, imageArray.byteLength))
			const imageData = new ImageData( imageArray.slice(), width, height )
			ctx.putImageData(imageData, 0, 0)
		}
		console.log(Date.now())
		setInterval
		(function(){
			console.log(Date.now())
			updateCanvas()
			}, 100)
	};
	workerInstance.postMessage({width, height});
});
