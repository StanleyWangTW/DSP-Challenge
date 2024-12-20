clear;
path(path, '.\PQevalAudio');
path(path, '.\PQevalAudio\CB');
path(path, '.\PQevalAudio\Misc');
path(path, '.\PQevalAudio\MOV');
path(path, '.\PQevalAudio\Patt');
path(path, '.\sounds');

[enhanced_music, ~] = audioread('output_music_compensated_113061530.wav');
[ref_music, fs] = audioread('answer.wav');

min_length = min([length(enhanced_music), ...
                 length(ref_music)]);

% to same length
enhanced_music = enhanced_music(1:min_length);
ref_music = ref_music(1:min_length);

% resample to 48kHz
enhanced_resampled = resample(enhanced_music, 48000, fs);
ref_resampled = resample(ref_music, 48000, fs);

% save 48kHz .wav
audiowrite('enhanced_48k.wav', enhanced_resampled, 48000);
audiowrite('answer_48k.wav', ref_resampled, 48000);

[odg, movb] = PQevalAudio_fn('answer_48k.wav', 'enhanced_48k.wav');
odg