
function run(){
	var start = new Date().getTime();
	var list = [];
	for(var number = 2; ; number++){
		if(!isPrime(number)) continue;
		list.push(number);
		if(list.length == 10000){
			console.log("10000th prime is " + number + "\n");
			break;
		}
	}
	var end = new Date().getTime();
	console.log("duration is " + (end - start) + " msec\n");
}

function isPrime(number){
	for(var n = 2; n < Math.floor(number/2); n++){
		if(number % n == 0) return false;
	}
	return true;
}

run();
