using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Pickable : MonoBehaviour, IGravitySensitive
{
    Rigidbody2D _rgbd;

    void Awake()
    {
        _rgbd = GetComponent<Rigidbody2D>();
    }

    public void GetExtraForce(float extraForce, Vector3 center)
    {
        Vector3 dir = center - transform.position;
        _rgbd.AddForce(dir.normalized * extraForce);
    }

    public void PickedUp()
    {
        Destroy(gameObject);
    }
}
