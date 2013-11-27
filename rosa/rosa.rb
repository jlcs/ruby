def getdata(probNum)
	f = File.open("rosa_data.txt", "r")
	target = "rosa" + probNum.to_s
	line = ""
	until line.chomp == target
		begin
			line = f.readline
		rescue EOFError
			puts "No matching problem!"
			f.close
		end 
	end
	numLines = f.readline.to_i
	data = ""
	numLines.times { data += f.readline }
	f.close
	return data
end
	
module Rosa
	def rosa_1 (string) #DNA
		return nil if !string.is_a? String
		h = Hash.new(0)
		string.split('').each {|char| h[char] += 1} # count characters
		h = h.sort {|l,r| l[0]<=> r[0]} # alphabetically sort array made from h 
		h.each {|x| print x[1].to_s + " "}
	end

	def rosa_2 (string) #RNA
		puts string.gsub!('T', 'U')
	end

	def rosa_3(string) #REVC
		puts string.reverse!.gsub!(/[ACGT]/, {'A'=>'T', 'T'=>'A', 'G'=>'C', 'C'=>'G'})
	end

	def rosa_4(n,k) #FIB
		f = []
		f << 1 << 1
		(2...n).each {|i| f << f[i-1] + k*f[i-2]}
		return f[-1]
	end

	def rosa_5(string) #GC
		string = string.split("\r\n")
		n = string.length / 3
		h = {}
		(0...n).each {|i| h[string[3*i]] = string[3*i+1] + string[3*i+2]}
		gcc = {}
		h.each {|label, dna| gcc[label] = Float(dna.count("GC")) / Float(dna.length)}
		
		maxcontent = 0
		maxlabel = ""
		 gcc.each do |label, content| 
			if content > maxcontent
				maxcontent = content
				maxlabel = label
			end
			#maxlabel, maxcontent = content > maxcontent ? label, content : maxlabel, maxcontent
		end
		puts "#{maxlabel}\n#{maxcontent}"
	end
	
	
end

probNum = ARGV[0]	
data = getdata(ARGV[0])
puts("data: #{data}")

solver = "rosa_" + probNum

include Rosa
puts Rosa.send(solver, data)