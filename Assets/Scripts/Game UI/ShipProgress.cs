using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;

public class ShipProgress : MonoBehaviour, IPlayerNeeder
{
    Transform _playerTransf;
    Vector3 _portalPosition;

    Slider _sliderProgress;

    float _startDistance;
    float _extentsOffset;

    public float minSlidePos, maxSlidePos;

    public event Action<float> onChangeDistance = delegate { };

    Action _updateUsingPlayer;

    private void OnEnable()
    {
        EventsManager.SubscribeToEvent(Constants.EVENT_SetPlayer, GetPlayer);
        EventsManager.SubscribeToEvent(Constants.EVENT_PlayerDeath, LoosePlayer);
    }

    void Start()
    {
        _sliderProgress = GetComponent<Slider>(); // Get the slider to work on it
    }

    void LateUpdate()
    {
        _updateUsingPlayer?.Invoke();
    }

    private void OnDisable()
    {
        EventsManager.UnsubscribeToEvent(Constants.EVENT_SetPlayer, GetPlayer);
        EventsManager.UnsubscribeToEvent(Constants.EVENT_PlayerDeath, LoosePlayer);
    }
    
    public void GetPlayer(params object[] p)
    {
        _playerTransf = ((ShipModel)p[0]).transform; // Player transform. It will be updated every frame because he moves

        Initialize();

        _updateUsingPlayer = CheckProgress;
    }

    public void LoosePlayer(params object[] p)
    {
        _updateUsingPlayer = null;
    }

    void Initialize()
    {
        var _objetiveTransf = FindObjectOfType<EndPortal>().transform; // Objetive transform

        _portalPosition = _objetiveTransf.position;  // Static position of the objetive

        _extentsOffset = _objetiveTransf.GetComponent<CircleCollider2D>().bounds.extents.x + _playerTransf.GetComponent<BoxCollider2D>().bounds.extents.x; //Player + objetive extents

        var dirToShip = (_playerTransf.position - _portalPosition).normalized; // As the player position is updated every frame I have to update my direction to ship

        var finalPosition = _portalPosition + dirToShip * _extentsOffset; // Static objetive position + updated direction to ship + player and objetive bound extents

        _startDistance = Vector3.Distance(_playerTransf.position, finalPosition);
    }

    void CheckProgress()
    {
        var dirToShip = (_playerTransf.position - _portalPosition).normalized; // As the player position is updated every frame I have to update my direction to ship

        var finalPosition = _portalPosition + dirToShip * _extentsOffset; // Static objetive position + updated direction to ship + player and objetive bound extents

        float distance = Vector3.Distance(_playerTransf.position, finalPosition) / _startDistance;

        float newProgress = Mathf.Lerp(maxSlidePos, minSlidePos, distance); ;

        _sliderProgress.value = newProgress;
        onChangeDistance(newProgress);
    }

}
