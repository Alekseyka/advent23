res = 0

def find_opers(ans, nums, print=false)
   if nums.size == 1
     return true if ans == nums[0]
   elsif nums.size == 2
    if ans == nums[0] + nums[1] || ans == nums[0] * nums[1]
        return true 
    else 
        return false
    end 
   else
     nums2 = nums.map(&:clone)
     nums2[1] = nums[0] + nums[1] 
     nums2 = nums2[1..-1]

     nums3 = nums.map(&:clone)
     nums3[1] = nums[0] * nums[1]
     nums3 = nums3[1..-1]
     
     return find_opers(ans, nums2, print) || find_opers(ans, nums3, print)
   end
   return false 
end

File.open('input2.txt', 'r') do |file|
    file.each_line do |line|
      a = line.strip.split(": ")
      ans = a[0].to_i
      nums = a[1].split(" ").map {|s| s.to_i }
      
      res += ans if find_opers(ans, nums)
    end
end

pp res