using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShipView : MonoBehaviour
{
    Animator _myAnim;

    void Start()
    {
        _myAnim = GetComponent<Animator>();
    }

    public void UseBoost(bool b)
    {
        _myAnim.SetBool("BoostPressed", b);
    }
}
