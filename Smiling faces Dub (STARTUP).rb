use_bpm 105

live_loop :hhat do
  with_fx :slicer, phase: 6, wave: 1, pulse_width: 0.666, mix: 1 do
    64.times do
      ##| sample :drum_cymbal_closed, release: rrand(0.1,0.20), amp: 7, cutoff: rrand(110,120), rate: 2 if spread(13,16,rotate: 3).tick(:I)
      sleep 0.25
    end
  end
end

live_loop :DH do
  with_fx :slicer, phase: 6, wave: 1, pulse_width: 0.666, mix: 0 do
    8.times do
      ##| sample :elec_fuzz_tom, amp: ring(0,3,3).tick(:ii)*2, rate: 1.9 if spread(3,8,rotate: 0).tick(:I)
      sleep 0.25
    end
  end
end

live_loop :metro1 do
  4.times do
    ##| sample :bd_haus, amp: 9, cutoff: 90
    sleep 0.5
    ##| sample :drum_cymbal_pedal, amp: 4, rate: 1.7
    sleep 0.5
  end
end

in_thread do
  live_loop :beat4 do
    tick_reset
    a = 2
    ##| sample :bd_haus, amp: 8, cutoff: 100
    sleep 1*a
    with_fx :gverb, room: 50, tail_level: 0.9, release: 3, mix: 0.8, damp: 0 do
      ##| sample :elec_snare, amp: 6, cutoff: 110, rate: 2.2
    end
    sleep 0.75*a
    2.times do
      with_fx :echo, phase: ring(nil,0.25).tick, decay: 1, mix: ring(0,1).look do
        ##| sample :bd_haus, amp: 8, cutoff: 100
      end
      sleep ring(0.5,0.75).look*a
    end
    with_fx :gverb, room: 50, tail_level: 0.9, release: 3, mix: 0.8, damp: 0 do
      ##| sample :elec_pop, amp: ring(4,4).choose, cutoff: 110, rate: 2.2
    end
    sleep 1
    with_fx :gverb, room: 45, release: 8, tail_level: 0.9, mix: 0.7 do
      ##| sample :elec_twip, amp: ring(6,6).choose, cutoff: 110, rate: 1.2
    end
    sleep 1
    ##| stop
  end
end


live_loop :bass2 do
  with_fx :lpf,  cutoff: 60, cutoff_slide: 64, mix: 0 do |e|
    ##| control e, cutoff: 120
    ##| 8.times do
    a = 0
    with_fx :gverb, room: 20, release: 1, mix: 0.3, amp: 1 do
      with_fx :distortion, distort: 0.8, mix: a*0.4 do
        with_fx :slicer, phase: 0.25, wave: 0, pulse_width: 0.666, mix: a*1 do
          tick(:ii)
          ##| synth :dsaw, note: knit(60,3,60+3,1,60-4+12,1,60+5,1,60-2+5,1,60-5+3,1).look(:ii)-36+5, detune: 0.3, sustain: knit(8,7,4,1).look(:ii), release: 0, amp: 3, cutoff: 120, env_curve: 6
          ##| synth :dsaw, note: knit(60,1,60+5,1,60-4+12,1,60+5,1,60,1,60+5,1,60-2+5,1,60-5+3,1).look(:ii)-36+5, detune: 0.3, sustain: 8, release: 0, amp: 3, cutoff: 120, env_curve: 1
          8.times do
            tick(:i)
            ##| synth :tb303, note: knit(60,4,60-2,4,60-4+12,4,60-5,4,60+5,4,60-2+5,4,60-4,4,60-5+3,4).look(:i)-36+5, sustain: 0, release: 1, amp: 1, cutoff: 50, cutoff_slide: 0.5, env_curve: 4
            ##| synth :fm, note: knit(60,4,60-2,4,60-4,4,60-5,4,60+5,4,60-2+5,4,60-4,4,60-5+3,4).look(:i)-24+5, depth: 4, release: 0.25*3, amp: 5, cutoff: 90
            sleep ring(1,1,1,2,0.75,0.75,0.5,1).look(:i)
          end
        end
      end
    end
    ##| end
  end
end


live_loop :keys do
  ##| tick_reset
  with_fx :slicer, phase: 1, wave: 3, phase_offset: 0.5, mix: 1 do
    with_fx :gverb, room: 50, release: 6, mix: 0.8, amp: 0.9 do
      2.times do
        tick
        a = ring(4.5,3.5).look
        b = 0
        ##| synth :zawa, note: chord(ring(60,60-2,60-4,60-5).look+12, ring(:minor7 ,:major, :major7,:minor7).look, invert: ring(-1,0).look)+0, amp: 2, sustain: a, release: 0, cutoff: 75
        synth :beep, note: chord(ring(60,60-2,60-4,60-5).look-0, ring(:minor7 ,:major, :major7,:minor7).look)+0, amp: 5, sustain: a, cutoff: 120
        sleep a
      end
    end
  end
end

live_loop :bass do
  with_fx :gverb, room: 50, release: 3, mix: 0.5, amp: 1 do
    with_fx :slicer, phase: 1, phase_offset: 0.5, mix: 1 do
      tick_reset
      cd = synth :dsaw, note: 65+0, note_slide: 5, attack: 16, sustain: 32, release: 16, amp: 1, detune: 0.2
      sleep 16
      5.times do
        control cd, note: ring(65+7,65+5).tick
        sleep knit(8,4,16,1).look
      end
    end
  end
end

##| in_thread do
##|   live_loop :counter do
##|     with_fx :gverb, room: 70, release: 8, mix: 0.6 do
##|       with_fx :slicer, phase: 0.25*3, wave: 2, mix: 0 do
##|         16.times do
##|           tick
##|           ##| synth :sine, note: ring(nil,nil,nil,nil,nil,45,43,45,nil,nil,nil,nil,nil,45,43,47).look+12+8, attack: 0, sustain: 0, release: 0.25, amp: 6, detune: 0.2, cutoff: 100
##|           sleep ring(2.5,2.5,1,0.5,0.5,0.25,0.25,0.5).look*1
##|         end
##|       end
##|     end
##|   end
##| end