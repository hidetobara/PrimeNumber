
function run(items){
	var limit = 10000;
	if(items.length == 3) limit = parseInt(items[2]);

	var start = new Date().getTime();
	var list = [];
	for(var number = 2; ; number++){
		if(!isPrime(number)) continue;
		list.push(number);
		if(list.length == limit){
			console.log(limit + "th prime is " + number);
			break;
		}
	}
	var end = new Date().getTime();
	console.log("[node] duration is " + (end/1000 - start/1000) + " sec");
}

function isPrime(number){
	for(var n = 2; n < Math.floor(number/2)+1; n++){
		if(number % n == 0) return false;
	}
	return true;
}

run(process.argv);
