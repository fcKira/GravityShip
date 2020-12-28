using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowCamera : MonoBehaviour, IPlayerNeeder
{
    Transform _target;

    private void OnEnable()
    {
        EventsManager.SubscribeToEvent(Constants.EVENT_SetPlayer, GetPlayer);
    }

    void LateUpdate()
    {
        transform.position = new Vector3(_target.position.x, _target.position.y, -10);
    }

    private void OnDisable()
    {
        EventsManager.UnsubscribeToEvent(Constants.EVENT_SetPlayer, GetPlayer);
    }

    public void GetPlayer(params object[] p)
    {
        _target = ((ShipModel)p[0]).transform;
    }
}
