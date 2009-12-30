class IP_Maker
  VALID_IP_RANGE = 0..255
  
  def initialize
    @ip = [0, 0, 0, 0]
  end
  
  def generate
    output = @ip.join('.')
    increment
    output
  end
  
  private
  
  def increment
    3.downto(0) do |i|
      @ip[i] += 1
      if !VALID_IP_RANGE.include? @ip[i]
        @ip[i] = 0
      else
        break
      end
    end
  end
end