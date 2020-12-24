using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShipController
{
    ShipModel _m;

    public ShipController(ShipModel m, ShipView v)
    {
        _m = m;
    }

    public void ControllerFixedUpdate()
    {
        _m.Movement();
    }
}
