using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Planet : AttractorObj
{
    public float rotationSpeed;

    private void Awake()
    {
        transform.rotation = Quaternion.Euler(new Vector3(0,0, Random.Range(0f, 360)));
    }

    private void Update()
    {
        transform.Rotate(Vector3.forward * rotationSpeed);
    }
}
