using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SimpleParticleLifetime : MonoBehaviour
{
    float _lifeTime;
    float _ticks = 0;

    void Awake()
    {
        _lifeTime = GetComponent<ParticleSystem>().main.startLifetime.constant;
    }

    void Update()
    {
        if (_ticks >= _lifeTime)
            Destroy(gameObject);

        _ticks += Time.deltaTime;
    }
}
