using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AttractorObj : Attractor
{
    protected override void Attract()
    {
        var shipCollider = Physics2D.OverlapCircle(transform.position, attractRadius, FlyweightPointer.Asteroid.layerMaskForPlanets);

        if (shipCollider)
        {
            shipCollider.GetComponent<IGravitySensitive>().GetExtraForce(attractForce, transform.position);
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawWireSphere(transform.position, attractRadius);
    }
}
