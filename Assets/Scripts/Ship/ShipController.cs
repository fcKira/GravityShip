﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShipController
{
    ShipModel _m;

    public ShipController(ShipModel m, ShipView v)
    {
        _m = m;

        _m._onBoost += v.UseBoost;
    }

    public void ControllerFixedUpdate()
    {
        _m.Movement();

        if (Input.touchCount > 0)
        {
            Touch touch = Input.GetTouch(0);
            _m.RotateShip(touch.position);
        }
        else if (Input.GetMouseButton(0))
        {
            Vector3 mousePosition = Input.mousePosition;

            _m.RotateShip(Input.mousePosition);

        }
    }
}
