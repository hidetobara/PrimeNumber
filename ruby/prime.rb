
def is_prime(num)
	for n in 2...(num/2+1)
		if num % n == 0 then
			return false
		end
	end
	return true
end

def search()
	limit = 10000
	if ARGV.count == 1 then
		limit = ARGV[0].to_i
	end
	start = Time.now
	count = 0
	num = 1
	while count < limit
		num += 1
		if is_prime(num) then
			count += 1
		end
	end
	puts "%dth prime is %d" % [limit, num]
	puts "[ruby] duration is #{Time.now - start} sec"
end

search()
