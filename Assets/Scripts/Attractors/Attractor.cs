using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class Attractor : MonoBehaviour
{
    public float attractForce;
    public float attractRadius;

    protected virtual void FixedUpdate()
    {
        Attract();
    }

    protected abstract void Attract();
}
