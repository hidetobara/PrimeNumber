
def is_prime(num)
	for n in 2...num/2
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
	num = 2
	while count < limit
		if is_prime(num) then
			count += 1
		end
		num += 1
	end
	puts "%dth prime is %d" % [limit, num]
	puts "[ruby] duration is #{Time.now - start} sec"
end

search()
