using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public interface IGravitySensitive
{
    void GetExtraForce(float extraForce, Vector3 center);
}
