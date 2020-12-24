using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttractorObj : MonoBehaviour
{
    public float attractForce;
    public float attractRadius;

    private void FixedUpdate()
    {
        var shipCollider = Physics2D.OverlapCircle(transform.position, attractRadius, FlyweightPointer.Asteroid.layerMask);

        if (shipCollider)
        {
            shipCollider.GetComponent<ShipModel>().GetExtraForce(attractForce, transform.position);
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position, attractRadius);
    }
}
