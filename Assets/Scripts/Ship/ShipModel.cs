using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShipModel : MonoBehaviour
{
    public float baseSpeed;
    public float boostSpeed;

    ShipController _controller;

    float _totalSpeed;

    Rigidbody2D _rgbd;

    public bool boolean;

    void Awake()
    {
        _controller = new ShipController(this, GetComponent<ShipView>());

        _rgbd = GetComponent<Rigidbody2D>();

        _totalSpeed = baseSpeed;

        _rgbd.velocity = transform.right * _totalSpeed;

    }

    void FixedUpdate()
    {

        _controller.ControllerFixedUpdate();

        //if (boolean) StartBoost();
        //else StopBoost();

    }

    public void Movement()
    {
        if (_rgbd.velocity.magnitude < _totalSpeed)
        {
            _rgbd.AddForce(transform.right * _totalSpeed);
        }

        transform.right = _rgbd.velocity.normalized;
    }

    public void StartBoost()
    {
        //_totalSpeed = boostSpeed + baseSpeed;
        _totalSpeed += boostSpeed;
    }

    public void StopBoost()
    {
        //_totalSpeed = baseSpeed;
        _totalSpeed -= boostSpeed;
    }

    public void GetExtraForce(float extraForce, Vector3 center)
    {
        Vector3 dir = center - transform.position;
        _rgbd.AddForce(dir.normalized * extraForce);
    }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.GetComponent<AttractorObj>())
            UnityEngine.SceneManagement.SceneManager.LoadScene(UnityEngine.SceneManagement.SceneManager.GetActiveScene().buildIndex);
    }
}
