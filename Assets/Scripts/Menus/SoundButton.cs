using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Audio;
using System;

public class SoundButton : MonoBehaviour
{
    Image _volumeImage;

    AudioMixer _audMixer;
    //Sprite _volumeOffSprite, _volumeOnSprite;

    Action OnChangeAudioVolume;

    void Awake()
    {
        //_volumeOffSprite = Resources.Load<Sprite>("UI/SoundOffButtonShape");
        //_volumeOnSprite = Resources.Load<Sprite>("UI/SoundOnButtonShape");

        _audMixer = Resources.Load<AudioMixer>("AudioMixer");
        _volumeImage = GetComponent<Image>();

        _audMixer.GetFloat("MyGeneralVolume", out float startVolume);
        if (startVolume == -80)
        {
            //_volumeImage.sprite = _volumeOffSprite;
            OnChangeAudioVolume = VolumeOn;
        }
        else
        {
            //_volumeImage.sprite = _volumeOnSprite;
            OnChangeAudioVolume = VolumeOff;
        }

    }

    public void ChangeVolumeBTN()
    {
        OnChangeAudioVolume();
    }

    void VolumeOff()
    {
        _audMixer.SetFloat("MyGeneralVolume", -80f);
        //_volumeImage.sprite = _volumeOffSprite;
        OnChangeAudioVolume = VolumeOn;
    }

    void VolumeOn()
    {
        _audMixer.SetFloat("MyGeneralVolume", 0f);
        //_volumeImage.sprite = _volumeOnSprite;
        OnChangeAudioVolume = VolumeOff;
    }
}
