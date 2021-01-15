using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShipView : MonoBehaviour
{
    public GameObject boostParticle;
    Transform _root;
    Transform _particlePosition;
    Animator _myAnim;
    GameObject _deathParticle;

    private void Awake()
    {
        _deathParticle = Instantiate(Resources.Load<GameObject>("Particles/PlayerCrash Particle"));
        _deathParticle.SetActive(false);
        _deathParticle.transform.SetParent(_root);

        _particlePosition = transform.parent;
    }

    void Start()
    {
        _myAnim = GetComponent<Animator>();
    }

    public void SetRoot(Transform root)
    {
        _root = root;
    }

    public void UseBoost(bool b)
    {
        _myAnim.SetBool("BoostPressed", b);

        boostParticle.SetActive(b);
    }

    public void Death()
    {
        _deathParticle.transform.position = _particlePosition.position;
        _deathParticle.SetActive(true);
    }
}
