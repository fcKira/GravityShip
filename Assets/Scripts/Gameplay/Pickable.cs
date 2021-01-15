using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Pickable : MonoBehaviour, IGravitySensitive
{
    Rigidbody2D _rgbd;

    GameObject _myPickedParticle;

    public event System.Action onPickedUp;

    void Awake()
    {
        _rgbd = GetComponent<Rigidbody2D>();

        _myPickedParticle = Instantiate(Resources.Load<GameObject>("Particles/AlienPicked Particle"));
        _myPickedParticle.SetActive(false);
        _myPickedParticle.transform.SetParent(transform.parent);
    }

    public void GetExtraForce(float extraForce, Vector3 center)
    {
        Vector3 dir = center - transform.position;
        _rgbd.AddForce(dir.normalized * extraForce);
    }

    public void PickedUp()
    {
        onPickedUp?.Invoke();
        _myPickedParticle.transform.position = transform.position;
        _myPickedParticle.SetActive(true);
        Destroy(gameObject);
    }
}
