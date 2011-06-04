=begin rdoc
*Module_Name*
  Popup

*Description*
  Test script popup methods

*Variables*
    

=end

module  Popup
  #TODO include Setup module in order to pass the systemos class variables.
  # there should be a more appropriate way to do this
  include Setup


  #    - thread based method to login to web page
  #    - acknowledge security alert
  #    - uses standard .click as opposed to .click_no_wait
  def login(site,user,pswd)

    conn_to = @@titl + site
    Thread.new{
      thread_cnt = Thread.list.size
      sleep 1 #This sleep is critical, timing may need to be adjusted
      Watir.autoit.WinWait(conn_to)
      Watir.autoit.WinActivate(conn_to)
      Watir.autoit.Send(user)
      Watir.autoit.Send('{TAB}')
      Watir.autoit.Send(pswd)
      popup('Windows Internet Explorer',@@ok) #launch thread for alert popup
      Watir.autoit.Send('{ENTER}')
    }
  end


  #
  #   - thread based method to acknowledge security alert
  def popup(name,btn) #alert popup thread
    Thread.new{
      sleep 1 # This sleep is critical, timing may need to be adjusted
      Watir.autoit.WinWait(name)
      Watir.autoit.ControlClick(name,"",btn)
    }
  end

  
  #
  #  - Handle popup and return pop up text if 'rtxt' is true
  #  - user_input is used for firmware update file dialogue box
  def jsClick(button, user_inp = nil,rtxt = nil)
    if button=="OK"||button=="È·¶¨"
      button=@@ok
    else
      button =@@cancel
    end
    wait = 70
    hwnd1 = $ie.enabled_popup(wait) # wait up to 60 seconds for a popup to appear
    if (hwnd1)
      w = WinClicker.new
      popup_text = w.getStaticText_hWnd(hwnd1).to_s.delete "\n"
      if (user_inp)
        w.setTextValueForFileNameField(hwnd1, "#{user_inp}")
      end
      sleep (0.1)
      w.clickWindowsButton_hwnd(hwnd1, "#{button}")
      w = nil
    end
    return popup_text
  end


  #
  #  - after attempting to save an invalid character - reset OK or
  #  - reset Cancel And reset OK, return text in popup
  def invChar( a,pop_exp,user_inp = nil)
    save.click_no_wait
    poptxt = jsClick(@@ok ,user_inp = nil,"rtxt")
    if (pop_exp == "can")
      reset.click_no_wait
      jsClick(@@cancel ,user_inp = nil)
      edit.click
    end
    reset.click_no_wait
    jsClick(@@ok ,user_inp = nil)
    return poptxt
  end


  #
  #  - reset Cancel or reset OK, implicitly return text in popup
  #  - res = Reset
  #  - can = Cancel
  def res_can(pop_exp)
    if (pop_exp == "res")
      reset.click_no_wait
      jsClick(@@ok,user_inp = nil,"rtxt")
    elsif (pop_exp == "can")
      reset.click_no_wait
      jsClick(@@cancel,user_inp = nil,"rtxt")
    end
  end


  #
  #  - reset to factory defaults ok or cancel, return text in popup
  def res_factory(pop_exp)
    if (pop_exp == "res")
      restart1.click_no_wait
      jsClick(@@ok,user_inp = nil,"rtxt")
    elsif (pop_exp == "can")
      restart1.click_no_wait
      jsClick(@@cancel,user_inp = nil,"rtxt")
    end
  end


  #
  # - returns popup text
  def popup_handler(button_to_push)
    wait = 70
    window_handle = $ie.enabled_popup(wait) # wait up to 70 seconds for a popup to appear
    if (window_handle)
      w = WinClicker.new
      popup_text = w.getStaticText_hWnd(window_handle).to_s.delete "\n"
      sleep (0.1)
      w.clickWindowsButton_hwnd(window_handle, "#{button_to_push}")
      w = nil
    end
    puts "pop-up text = #{popup_text}"
    return popup_text
  end

end