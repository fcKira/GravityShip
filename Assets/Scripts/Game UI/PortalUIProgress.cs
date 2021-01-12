using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PortalUIProgress : MonoBehaviour
{
    Image _myImage;

    public Color nearColor, farColor;
    public float anglesToRotate;

    void Start()
    {
        _myImage = GetComponent<Image>();

        var shipProgress = FindObjectOfType<ShipProgress>();

        if (shipProgress)
        {
            shipProgress.onChangeDistance += ChangeColor;
        }
    }

    private void Update()
    {
        transform.Rotate(Vector3.forward * anglesToRotate);
    }

    void ChangeColor(float f)
    {
        _myImage.color = Color.Lerp(nearColor, farColor, f);
    }
}
