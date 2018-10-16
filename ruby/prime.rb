
def is_prime(num)
	for n in 2...num/2
		if num % n == 0 then
			return false
		end
	end
	return true
end

def search()
	start = Time.now
	count = 0
	num = 2
	while count < 10000
		if is_prime(num) then
			count += 1
		end
		num += 1
	end
	puts "10000th prime is %d" % num
	puts "[ruby] duration is #{Time.now - start} sec"
end

search()
