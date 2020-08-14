require_relative '../lib/prompter.rb'
class Linters < Prompter
include FileReader
attr_reader :file_data,:open_bracket,:closing_bracket,:result
  def initialize
    @file_data = file_data
    @open_bracket = open_bracket
    @closing_bracket = closing_bracket
    @result = result
  end
    
    # if @file_data.match(@open_bracket).to_s == "{" && @file_data.match(@closing_bracket).to_s == "}" 
    #     prompt_message('passed')
    #     true
    # else
    #     prompt_message('failed')
    #     false
    # end
    
    #toplam parantez sayısı çift olması 
    #hiç parantez olmaması
    #duplike parantez olması durumu
    #bir içerik te olup diğerinde olmaması

    def missing_tag_checker
      @file_data = file_read
      @open_bracket = (/{/)
      @closing_bracket = (/}/)
      @duplicate_open = (/{{/)
      @duplicate_close = (/}}/)
      
      matchs = @file_data.scan(@open_bracket).size + @file_data.scan(@closing_bracket).size
      if matchs.even? && matchs != 0 && @file_data.size != 2 
        prompt_message('passed')
      elsif matchs.odd? == true && matchs != 0
        prompt_message('failed')
        prompt_lint('missing_tag')
      elsif matchs == 0
        prompt_message('failed')
        prompt_lint('no_brackets')
      elsif @file_data.split('').values_at(0) == ['{'] && @file_data.split('').values_at(-1) == ['}'] 
        prompt_message('passed')
      end
    end


end