using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class FollowCamera : MonoBehaviour, IPlayerNeeder
{
    Transform _target;

    Action _updateUsingPlayer;

    private void OnEnable()
    {
        EventsManager.SubscribeToEvent(Constants.EVENT_SetPlayer, GetPlayer);
        EventsManager.SubscribeToEvent(Constants.EVENT_PlayerDeath, LoosePlayer);
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
        _target = ((ShipModel)p[0]).transform;
        var t = ((ShipModel)p[0]).transform;
        _updateUsingPlayer = () => transform.position = new Vector3(t.position.x, t.position.y, -10);
    }

    public void LoosePlayer(params object[] p)
    {
        _updateUsingPlayer = null;
    }
}
