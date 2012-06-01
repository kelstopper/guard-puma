require 'net/http'

module Guard
  class PumaRunner

    attr_reader :options, :control_url, :control_token, :cmd_opts

    def initialize(options)
      @control_token = (options.delete(:control_token) || 'pumarules')
      @control = "0.0.0.0"
      @control_port = (options.delete(:control_port) || '9293')
      @control_url = "#{@control}:#{@control_port}"
      @options = options

      puma_options = {
        '--port' => options[:port],
        '--control-token' => @control_token,
        '--control' => "tcp://#{@control_url}"
      }
      [:config, :bind, :threads].each do |opt|
        puma_options["--#{opt}"] = options[opt] if options[opt]
      end
      @cmd_opts = (puma_options.to_a.flatten << '-q').join(' ')
    end

    def start
      puts "start called"
      system %{sh -c 'cd #{Dir.pwd} && puma #{cmd_opts} &'}
    end

    def halt
      puts "halt called"
      run_puma_command!("halt")
    end

    def restart
      puts "restart called"
      run_puma_command!("restart")
    end

    private
    
    def run_puma_command!(cmd)
      Net::HTTP.get_response(build_uri(cmd))
      #Net::HTTP.new(@control, @control_port).start do |http|
        #req = Net::HTTP::Get.new build_uri(cmd).request_uri
        #http.request req
      #end
      return true
    rescue EOFError
      # TODO Figure out WHY the stream is being closed
      return true
    rescue Errno::ECONNREFUSED
      # server may not have been started correctly.
      false
    end

    def build_uri(cmd)
      URI "http://#{control_url}/#{cmd}?token=#{control_token}"
    end

  end
end

