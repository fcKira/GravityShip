using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PickablesProgress : MonoBehaviour
{
    Animator[] _pickables;

    int _pickedIndex = 0;
    // Start is called before the first frame update
    void Start()
    {

        _pickables = GetComponentsInChildren<Animator>();

        var pickables = FindObjectsOfType<Pickable>();

        foreach (var item in pickables)
        {
            item.onPickedUp += PickedUp;
        }
    }
    
    void PickedUp()
    {
        _pickables[_pickedIndex].SetBool("Picked", true);

        _pickedIndex++;
    }
}
