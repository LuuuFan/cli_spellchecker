def edit_distance(str1, str2)
	dp = Array.new(str1.length + 1){Array.new(str2.length + 1)}
	(0..str1.length).each do |m|
		(0..str2.length).each do |n|
			if m == 0
				dp[m][n] = n
			elsif n == 0
				dp[m][n] = m
			elsif str1[m- 1] == str2[n - 1]
				dp[m][n] = dp[m - 1][n - 1]
			else
				dp[m][n] = 1 + [dp[m][n -1], dp[m - 1][n], dp[m - 1][n-1]].min
			end
		end
	end
	return dp.last.last
end