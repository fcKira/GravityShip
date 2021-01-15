using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;
using System;

public class GameManager : MonoBehaviour
{
    AudioMixer _audMixer;
    Action OnChangeAudioVolume;

    private void OnEnable()
    {
        EventsManager.SubscribeToEvent(Constants.EVENT_PlayerDeath, EndGame);
    }

    void Start()
    {
        EventsManager.TriggerEvent(Constants.EVENT_SetPlayer, FindObjectOfType<ShipModel>());

        ScreenManager.instance.InitializeScreens();

        var eS = Instantiate(Resources.Load<EmilyBeginScreen>("EmilyBeginCanvas"));
        ScreenManager.instance.Push(eS);

        /*AUDIO*/

        _audMixer = Resources.Load<AudioMixer>("AudioMixer");

        _audMixer.GetFloat("MyGeneralVolume", out float startVolume);
        if (startVolume == -80)
        {
            OnChangeAudioVolume = VolumeOn;
        }
        else
        {
            OnChangeAudioVolume = VolumeOff;
        }
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.M))
        {
            ChangeVolume();
        }
    }

    private void OnDisable()
    {
        EventsManager.UnsubscribeToEvent(Constants.EVENT_PlayerDeath, EndGame);
    }

    void EndGame(params object[] p)
    {
        StartCoroutine(TimeAfterNextState(1.5f, () => UnityEngine.SceneManagement.SceneManager.LoadScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex)));
    }

    public void ChangeVolume()
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


    IEnumerator TimeAfterNextState(float timer, Action callback)
    {
        float _ticks = 0;

        while(_ticks < timer)
        {
            _ticks += Time.deltaTime;
            yield return new WaitUntil(() => this.enabled);
        }

        callback();
    }
}
